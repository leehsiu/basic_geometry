mex -v GCC='/usr/bin/gcc-4.7' -DBUILD_MEX solveE.cc Ematrix_5pt.cc polyquotient.cc polydet.cc sturm.cc Ematrix_6pt.cc
mex -v GCC='/usr/bin/gcc-4.7' -DBUILD_MEX solveE_nister.cc Ematrix_5pt.cc polyquotient.cc polydet.cc sturm.cc Ematrix_6pt.cc
mex -v GCC='/usr/bin/gcc-4.7' -DBUILD_MEX partsolveE.cc Ematrix_5pt.cc sturm.cc polydet.cc polyquotient.cc
mex -v GCC='/usr/bin/gcc-4.7' -DBUILD_MEX partsolveE6.cc Ematrix_6pt.cc sturm.cc polydet.cc polyquotient.cc
