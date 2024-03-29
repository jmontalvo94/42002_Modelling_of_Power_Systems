Sets
t        timeperiods /t1*t24/
;

Parameter
e(t)     energy level

$call gdxxrw.exe InputExcel.xlsx par=e rng=Energy!A1:B24 rDim=1
$gdxin InputExcel.gdx
$load e
$gdxin
;

Free Variables
H        Happiness (objective) function value
;

*Integer Variables
*c        coffee level
*;

Positive Variables
s        study level
c        coffee level
b        biking level
;

Equations
Obj       objective function
cs14      constraint 14
cs15      constraint 15
cs16      constraint 16
cs17      constraint 17
*cs18      constraint 18
;

Obj ..   H =e= sum(t, 4*s - c*e(t) + 2*b);

cs14 ..   s + 3*c =g= 47;
cs15 ..   sum(t, -3*s + c*e(t)) =g= 21;
cs16 ..   5*s + b + c =l= 500;
cs17 ..   b + s =l= 100;
*cs18 ..   b =l= 12;

option limrow = 3;

model happiness /all/;

solve happiness using LP maximizing H;
*solve happiness using MIP maximizing H;

display H.L, s.L, c.L, b.L, cs14.M, cs15.M, cs16.M, cs17.M
