program prec
use,intrinsic:: iso_fortran_env, stderr=>error_unit
implicit none

! shows pitfall of not being mindful with input Kind

! NOTE that 9/5.0_dp  /=  9/5.0, even when the assigned variable is real(dp) !!

! NOTE: using gfortran option "-fdefault-real-8" fixes these problems!
! NOTE: using ifort option "-r8" fixes these problems!

real(real32) :: huge32 = 9/5.0_real32
real(real64) :: huge64 = 9/5.0_real64
real(real128) :: huge128 = 9/5.0_real128
integer(int64) :: hugeint64 = 9/5_int64

real(real64) :: imdouble = 9/5.

if (storage_size(imdouble) /= 64) then
  write(stderr,*) 'expected real64 but you have real bits: ', storage_size(imdouble)
  error stop
endif

if (storage_size(huge64) /= 64) then
  write(stderr,*) 'expected real64 but you have real bits: ', storage_size(huge64)
  error stop
endif

if (storage_size(huge32) /= 32) then
  write(stderr,*) 'expected real32 but you have real bits: ', storage_size(huge32)
  error stop
endif

if (storage_size(huge128) /= 128) then
  write(stderr,*) 'expected real128 but you have real bits: ', storage_size(huge128)
  error stop
endif

if (storage_size(hugeint64) /= 64) then
  write(stderr,*) 'expected int64 but you have integer bits: ', storage_size(hugeint64)
  error stop
endif

print *,'64-bit variable with 32-bit constants',imdouble
print *,'64-bit variable, 32-bit constants equal to all 64-bit constants?',imdouble==huge64
print *,'32-bit',huge32
print *,'64-bit',huge64
print *,'128-bit',huge128
print *,'64-bit Integer ',hugeint64


!  64-bit variable with 32-bit constants   1.7999999523162842     
! 64-bit variable, 32-bit constants equal to all 64-bit constants? F
! 32-bit   1.79999995    
! 64-bit   1.8000000000000000     
! 128-bit   1.80000000000000000000000000000000004      
! 64-bit Integer                    1
! kinds  sp dp qp i64
!           4           8          16           8
! Bit Patterns:
! 11011011111111111100110011001100110011000000000000000000000000000000
! 11011011111111111100110011001100110011001100110011001100110011001101


print *,'Bit Patterns:'

print '(A,B0)','64-bit variable with 32-bit constants ',imdouble
print '(A,B0)','64-bit variable with 64-bit constants ',huge64

end program
