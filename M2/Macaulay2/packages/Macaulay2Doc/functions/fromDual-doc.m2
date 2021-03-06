--- status: Draft
--- author(s): MES
--- notes: 

document {
     Key => "inverse systems",
     "Suppose that R = k[x1,...,xn], and that
     E = k[y1,...,yn] is the injective envelop of k.  IE, E is given the R-module structure:
     x^A . y^B = y^(B-A), if B-A >= 0 in every component, and x^A . y^B = 0 otherwise.",
     PARA{},
     "If I is an ideal of R, then the submodule I' = Hom_R(R/I,E) of E is called the
     (Macaulay) inverse system of I.  I is zero-dimensional if and only if I' is finitely generated.",
     PARA{},
     "This is a dual operation, since I can be recovered as ann_R(I').",
     PARA{},
     "In Macaulay2, currently the computation of the inverse system I' (toDual) and of the 
     ideal I from I' (fromDual) are restricted to the situation where I and I' are homogeneous.
     As an example, let's compute the ideal corresponding to a cubic.",
     EXAMPLE lines ///
     	 R = QQ[a..e];
	 g = matrix{{a^3+b^3+c^3+d^3+e^3-d^2*e-a*b*c-a*d*e}}
	 f = fromDual g
	 I = ideal f
	 ///,
     "The resulting ideal is always zero dimensional, and its Cohen-Macaulay type is the
     number of generators of the submodule E defined by g.  Therefore, if g is a 1 by 1 matrix,
     then the resulting ideal is Gorenstein.",
     EXAMPLE lines ///
	 res I
	 betti oo
         ///,
     PARA{},
     "The other direction (starting with an ideal I) is more complicated, since the result may not be finitely generated.
     So, we must give an integer d as well as the generators of I:",
     EXAMPLE lines ///
     	 toDual(3,f)
         ///,
     "The integer d has two interpretations.  The most general is that the (finitely generated)
     intersection of I' and the submodule generated by y1^d ... yn^d is returned.
     If the ideal I is zero dimensional, d should be an integer such that x^(d+1) is in I = image f for 
     every variable x.",
     EXAMPLE lines ///
         f = matrix{{a*b,c*d,e^2}}
	 toDual(1,f)
	 toDual(2,f)
	 toDual(3,f)
	 g = toDual(4,f)
	 fromDual g
	 ///,
     SeeAlso => {toDual, fromDual}
     },
     
document { 
     Key => fromDual,
     Headline => "ideal from inverse system",
     Usage => "fromDual g",
     Inputs => {
	  "g" => Matrix => "a one row matrix over a polynomial ring R, consisting of
	     homogeneous polynomials"
	  },
     Outputs => {
	  Matrix => {"a one row matrix f over R whose entries generate the homogeneous
	    ideal { h in R | h . g = 0 }, where the action is by contraction (see ", TO (contract,Matrix,Matrix), ")"}
	  },
     "For other examples, and a more precise definition, see ", TO "inverse systems", ".",
     EXAMPLE lines ///
          R = ZZ/32003[x_1..x_3];
	  g = random(R^1, R^{-4})
	  f = fromDual g
	  res ideal f
	  betti oo
          ///,
     SeeAlso => toDual
     }

TEST ///
    R = ZZ/101[a..d]
    f = matrix{{a^3 + b^3 + c^3 + d^3 + (a+b+c)^3}}
    fdual = fromDual f
    assert(f - toDual(4, fdual) == 0)
///

