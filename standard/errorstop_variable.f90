!! Fortran 2018 allows variable character for error stop, which is highly useful
character(:), allocatable :: b

b = 'this message is dynamic'

error stop b

end program
