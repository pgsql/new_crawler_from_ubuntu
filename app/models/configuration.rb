class Configuration < ActiveRecord::Base
  has_many :results
  scope :activated, where(:active => true)
  def convert_sec_to_mins()
    secs = 0
    secs = self.time_ran unless self.time_ran.blank?
    hours = secs/3600.to_i
    minutes = (secs/60 - hours * 60).to_i
    seconds = (secs - (minutes * 60 + hours * 3600))
    [hours,minutes,seconds]
  end
end
