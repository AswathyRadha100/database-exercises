##########################################################################################################################################
#     Functions IN SQL:-                                                                                                                                   # 
#   Goal:- Explore some SQL functions                                                                                                                                     #
###########################################################################################################################################

# 1.    ROUND()
-- The ROUND() function rounds a number to a specified number of decimal places.
 SELECT ROUND(325.671415, 2) AS RoundedValue;
 -- 325.67
 
 # 2.   SQRT() 
  -- The SQRT() function returns the square root of a number.
    SELECT SQRT(324);
    -- 18
    
 # 3.    TRUNC()
 -- Returns a number truncated to a specified number of decimal places.
     SELECT TRUNCATE(57235.4513, 3);
     -- 135.375
     
 # 4.    DIV()
 -- This function returns the quotient of a number divided by another number.
 -- syntax SELECT x DIV y;
  SELECT 78 DIV 2;
 -- 39
 
 # 5.    MOD(X,Y)
 -- The MOD() function returns the remainder of a number divided by another number.
-- syntax:  MOD( dividend, divisor )
SELECT MOD( 326, 3 );
-- 2

 
 # 6.    FLOOR( )
 -- The FLOOR() function returns the largest integer value that is smaller than or equal to a number.
SELECT FLOOR(52.85) AS FloorValue;
-- 52
 
 # 7.    CEILING()
-- The CEILING() function returns the smallest integer value that is larger than or equal to a number.
SELECT CEILING(52.85) AS CeilValue;
-- 53
 
 # 8.    ABS() 
 -- The ABS() function returns the absolute value of a number.
 SELECT Abs(-243.5) AS AbsNum;
 -- '243.5'

 
 # 9.    SQUARE()
  -- The SQUARE() function returns the square of a number.
  SELECT SQUARE(64);
  
  
# 10. EXP()
-- The EXP() function returns e raised to the power of a specified number.
-- syntax 
-- EXP(number)
SELECT EXP(4);
-- 54.598150033144236

