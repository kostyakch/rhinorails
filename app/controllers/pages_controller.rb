class PagesController < ApplicationController
    #caches_action :index, expires_in: 60.seconds, :cache_path => Proc.new { |c| "#{c.params}_#{cookies[:remember_token].to_s}" }      
    #caches_action :internal, expires_in: 60.seconds, :cache_path => Proc.new { |c| "#{c.params}_#{cookies[:remember_token].present?.to_s}" }      

    def index
        if params[:url] == 'index'
            render :template => 'site/not_found', :status => 404
            return
        end

        if !@page = Page.find_by_path('index')
            render :template => 'site/not_found', :status => 404
        end  
    end 

    def internal
        if params[:url] == 'index'
            render :template => 'site/not_found', :status => 404
            return
        end

        if !@page = Page.find_by_path(params[:url])
            render :template => 'site/not_found', :status => 404
            return
        end
    end


    
end
