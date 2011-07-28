#base lass for both ATS workers (TBNGo and BTNSearch)
#contains common methods
class ATSWorker < CSVMaker
  #saves simple HTML page with job details
  #decorates the page with <html><body> tags
  #those were sriped along with other jung
  def save_page(file_name, data, link)
    path = @job[:save_path]
    dirs = File.dirname(path)
    path = dirs+"/"+file_name+".html"
    data.gsub! /<img[^<]*>/, ""
    data = "<html>\n<body>\n<a href=\"#{link}\">#{file_name}</a>\n"+data+"\n</body>\n</html>"
    log "saving the result to DB: "+File.expand_path(path)+"\n--------------\n"
    File.makedirs(dirs)
    f = File.new path, "w"
    cnt = f.write data
    f.close
  end

  def save_data_page(file_name, data, link,result,configuration)
    path = @job[:save_path]
    dirs = File.dirname(path)
    path = dirs+"/"+file_name+".html"
    data.gsub! /<img[^<]*>/, ""
    data = "<html>\n<body>\n<a href=\"#{link}\">#{file_name}</a>\n"+data+"\n</body>\n</html>"
    log "saving page to DB: "+File.expand_path(path)+"\n--------------\n"
    result.update_attributes(:html_blob => data) if configuration.save_html_blob
    if configuration.save_html_file
      File.makedirs(dirs)
      f = File.new path, "w"
      cnt = f.write data
      f.close
    end
  end
  #"next" link has different format of "onclick" attribute
  #this method converts it to format acceptable by method 'decorate_form'
  def prepare_next_link_options(next_link)
    onclick = next_link["onclick"]
    onclick.to_s =~/\(([^(]*)\)/
    opt = $1.split ","
    #next_link_opt = "{event :#{opt[1]}, source :#{opt[2]}, value :#{opt[4]}, size :#{opt[5]}, partialTargets :''}"
    next_link_opt = "{event :#{opt[1]}, source :#{opt[2]}, value :#{opt[4]}, size :#{opt[5]}, partialTargets :JobSearchTable}"
    #next_link_opt = "{event :#{opt[1]}, source :#{opt[2]}, value :#{opt[4]}, size :#{opt[5]}, partialTargets :#{opt[6]}}"
    next_link["onclick"] = next_link_opt
  end

  #replace different HTML enteties and tags to sybols which mean/look the same
  #but have nice look in CSV/Excel files
  def html2csv(data)
    dbg= data.gsub! "\n", ""
    dbg= data.gsub! "\xA0", " "
    dbg= data.gsub! "\r", ""
    dbg = data.gsub! /<br>/, "\n"
    dbg = data.gsub! /<\/p>/, "\n"
    dbg = data.gsub! /<\/div>/, "\n"
    dbg = data.gsub! /<ul[^>]*>/, "\n"
    dbg = data.gsub! /<li[^>]*>/, "\x95 "
    dbg = data.gsub! /<\/li>/, "\n"
    dbg = data.gsub! /<\/?\??\w+[^>]*>/, ""
    dbg = data.gsub! /[ ]{2,}/, " "
    dbg = data.gsub! /(\s?\n\s?){2,}/, "\n"
    dbg = data.strip!
    return data
  end

  def update_last_run(config_id)
    @configuration = Configuration.find(config_id)
    @time_of_last_run  =  Time.now
    @configuration.time_of_last_run = @time_of_last_run
    @configuration.save
  end
  #TODO: Refractor the below method using the csv_row instead of passing  all the variables
  def update_result(config,result,location,organization_name,brief_description,job_requirements,additional_details,how_to_apply,link,department_description,detailed_description)
    result.location = location if config.location
    result.expired = false
    result.organization_name = organization_name if config.organization_name
    result.brieff_description = brief_description if config.brieff_description
    result.job_requirments = job_requirements if config.job_requirments
    result.additional_details = additional_details if config.additional_details
    result.how_to_apply = how_to_apply if config.how_to_apply
    result.detailed_description = detailed_description if config.detailed_description
    result.department_description = department_description if config.department_description
    result.link = link.to_s if config.link
    result.configuration_id = config.id
    result.save
  end

  def update_configuration(config)
    
    config.no_of_times_run = config.no_of_times_run.to_i + 1
    config.end_time = Time.now
    
    config.time_ran = config.end_time - config.last_run

    if config.first_time == 0
      config.first_time =  1
    else
      config.first_time =  2
    end
    config.save
  end

  #add fields from "onclick" event to form
  def decorate_form(form, onclick)

    fields = onclick.attr "onclick"
    fields.to_s =~ /\{([^}]+)\}/
    fields = $1
    fields = fields.split(",").map do |e|
      arr = e.gsub("'", "").split ":"
      arr.push "" unless arr.length == 2
      arr[0].strip!
      arr[1].strip!
      arr
    end
    fields.each do |field|
      form_field = form.field_with :name=>field[0]
      if form_field.nil?
        form.add_field! field[0]
        form_field = form.field_with :name=>field[0]
      end
      form_field.value= field[1]
    end
    return form
  rescue Exception => e
    puts e
  end
end