module Githook
  module Config
    class Syntax
      @@repos = { }
      def self.repos
        @@repos.values
      end
      def self.repos_hash
        @@repos
      end

      def initialize(name)
        @name = name
        @config = { name: name }
      end

      [:path, :remote, :branch].each do |attr|
        define_method(attr) {|value| @config[attr] = value}
      end
      def to_hash
        @config
      end
    end

    def self.repo(name, &blk)
      c = Syntax.new(name)
      c.instance_eval &blk

      Syntax.repos_hash[name] = Githook::Repo.new(c.to_hash)
    end
    def self.repos
      Syntax.repos
    end
  end
end
