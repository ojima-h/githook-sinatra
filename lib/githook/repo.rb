module Githook
  class Repo
    def initialize(config)
      @config = config
    end
    [:name, :path, :remote, :branch].each do |attr|
      define_method attr do
        @config[attr]
      end
    end
    def refspec
      "#{remote}/#{branch}"
    end
  end
end
