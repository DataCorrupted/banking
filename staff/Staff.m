classdef Staff < Entity
    properties (Access = protected)
        name
        manager
    end
    
    methods (Access = public)
        function this = Staff(name, password, sid, isManager)
            this@Entity(sid, password);
            this.name = name;
            this.manager = isManager;
        end
        
    end
end

