classdef Status < int32
    %STATUS Summary of this class goes here
    %   Detailed explanation goes here
    
   enumeration
      Successful         (0)
      Waiting            (1)
      Failed            (-1)
      Insuffice         (-2)
      InvalidAmount     (-3)
   end
end

