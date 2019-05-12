classdef Staff < Entity
    properties (Access = protected)
        name
        manager
    end
    
    methods (Access = public)
        function this = Staff(sid, name, password)
            this@Entity(sid, password);
            this.name = name;
            this.manager = 0;
        end
        
    end
end

