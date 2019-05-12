classdef (Abstract) Entity < handle
    properties
        id
        password
    end
    
    methods
        function this = Entity(id, password)
            this.id = id;
            this.password = password;
        end

        function isMatch = passwordMatch(this, password)
            isMatch = strcmp(this.password, password);
        end
        function id = getId(this)
            id = this.id;
        end
    end
end

