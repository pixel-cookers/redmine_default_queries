module QueryPerProject
  module Patches
    module QueriesHelperPatch
      def self.included(base) # :nodoc:
        base.send(:include, InstanceMethods)

        base.class_eval do
          unloadable # Send unloadable so it will not be unloaded in development

          alias_method_chain :retrieve_query, :default_query
        end

      end

      module ClassMethods
      end

      module InstanceMethods

        def retrieve_query_with_default_query
          # workaround bug in homepage plugin (if set to query_id, not possible to change custom at all)
          #if !@project && params[:set_filter] && params[:query_id]
          #  params.delete(:query_id)
          #end
          #
          
          if params[:query_id].blank? && (api_request? || params[:set_filter] || session[:query].nil? ||
             session[:query][:project_id] != (@project ? @project.id : nil) ||
             session[:query][:column_names].nil? )
         #   get_default_query
         
             cv=@project.custom_values.detect do |custom_value|
               true if custom_value.custom_field.name == "query_id" && !custom_value.value.blank?
             end
             #query_id = ( cv ? cv.value.to_s.strip : QPP_Constants::PROJECT_DEFAULT_SUFFIX )
             
             query_id = cv.value.to_s.strip unless cv.blank? 

            print "test #{query_id}"
            
            params[:query_id] = query_id unless query_id.blank?

            retrieve_query_without_default_query unless @query
          else
            retrieve_query_without_default_query
          end
        end

      end
      
      def should_apply_for_default_query?
        return false unless params[:query_id].blank?
        if api_request? || params[:set_filter] || session[:query].nil? ||
               session[:query][:project_id] != (@project ? @project.id : nil) ||
            session[:query][:column_names].nil?
          return true
        end
        return false
      end
      
    end
    

  end
end




unless QueriesHelper.included_modules.include? QueryPerProject::Patches::QueriesHelperPatch
  QueriesHelper.send(:include, QueryPerProject::Patches::QueriesHelperPatch)
end

