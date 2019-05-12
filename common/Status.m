classdef Status < int32
    %STATUS Summary of this class goes here
    %   Detailed explanation goes here
    
   enumeration
      Successful         (0)
      Waiting            (1)
      Failed            (-1)
      Insufficient      (-2)
      InvalidAmount     (-3)
      InvalidCustomer   (-4)
      InvalidAccount    (-5)
      WrongPassword     (-6)
   end
end

