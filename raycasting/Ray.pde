class Ray
{
  PVector origin, direction;
  float t, u;
  
  Ray(PVector origin, PVector direction)
  {
    this.origin = origin;
    this.direction = direction.normalize();
  }
  
  PVector cast(LineSegment lineSegment)
  {
    // Determine whether or not the lines are parallel using the 2D cross product
    // 2D cross product: Ax * By - Ay * Bx
    float parallelism = direction.x * lineSegment.segment.y - direction.y * lineSegment.segment.x;
    
    // If the cross product is 0 then the lines are parallel and the ray can't be cast onto the line segment
    if(parallelism == 0) return null;
    
    // If the two lines intersect and are not parallel this equality will be true
    // P + Rt = Q + Su
    
    // We must solve for the unknown scalars t and u which make this equality true
    // To solve for one of the scalars at a time we remove the other from the equation using the 2D cross product
    
    // Solving for t
    // P x S + (R x S)t = Q x S + (S x S)u
    // P x S + (R x S)t = Q x S
    // (R x S)t = Q x S - P x S
    // t = (Q - P) x S / R x S
    
    // Solving for u
    // Q x R + (S x R)u = P x R + (R x R)t
    // Q x R + (S x R)u = P x R
    // (S x R)u = P x R - Q x R
    // u = (P - Q) x R / S x R
    
    PVector P = origin;
    PVector R = direction;
    PVector Q = lineSegment.start;
    PVector S = lineSegment.segment;
    
    t = cross2D(PVector.sub(Q, P), S) / parallelism;
    u = cross2D(PVector.sub(P, Q), R) / -parallelism;
    
    // If t >= 0 and U >= 0 && u <= 1 then the point of intersection is in the
    // direction the ray is pointing and within the bounds of the line segment
    
    if(t < 0 || u < 0 || u > 1) return null;
    
    // Return the point of intersection P + Rt = Q + Su
    return PVector.add(P, PVector.mult(R, t));
  }
  
  float cross2D(PVector a, PVector b)
  {
    return a.x * b.y - a.y * b.x;
  }
  
  void render()
  {
    stroke(255);
    line(origin.x, origin.y, origin.x + direction.x * 20, origin.y + direction.y * 20);
  }
}
