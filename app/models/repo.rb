class Repo 
    attr_reader :name,
                :full_name
            
    def initialize(attributes)
        @name = attributes[:name]
        @full_name = attributes[:full_name]
    end 
end 