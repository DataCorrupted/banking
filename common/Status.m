classdef Status < int32
   enumeration
      Successful         (0)
      Waiting            (1)
      Failed            (-1)
      Insufficient      (-2)
      InvalidAmount     (-3)
      InvalidCustomer   (-4)
      InvalidAccount    (-5)
      WrongPassword     (-6)

      TicketInvalid     (-1)
      TicketVoided      (1)
      TicketTaken       (2)
      TicketCalled      (3)
      
   end
end

