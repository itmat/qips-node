require 'openwfe'

class WorkItemHelper

  def self.validate_workitem (wi)
    #work items need to have certain information in their parameters in order for the node to work
    #this method will check and see

    valid = true
    
    #first make sure this has a PID and command
    if wi.params['pid'].nil? || wi.params['command'].nil?
      valid = false
    end

    #then check and make sure it has an input bucket, or a prev_output bucket
    if wi.params['input-folder'].nil?  &&  wi.params['input-files'].nil? && ! wi.has_attribute?('prev_output_bucket')
      valid = false
    end

    valid = true if (wi.params['command'] && wi.params['instance-id'])

    return valid
  end



  def self.decode_message (message)
    
    o = Base64.decode64(message)
    o = YAML.load(o)
    o = OpenWFE::workitem_from_h(o)
    o
    
  end

  def self.encode_workitem (wi)
    
    msg = wi.to_h
    msg = YAML.dump(msg)
    msg = Base64.encode64(msg)
    msg
  end
  
end

