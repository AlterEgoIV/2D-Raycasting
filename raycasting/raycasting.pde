ArrayList<Ray> rays;
ArrayList<LineSegment> lineSegments;
int numRays, numSegments;
LineSegment top, bottom, left, right;
PVector r;

void setup()
{
  size(800, 600);
  
  rays = new ArrayList<Ray>();
  lineSegments = new ArrayList<LineSegment>();
  numRays = 360;
  numSegments = 5;
  top = new LineSegment(new PVector(0, 0), new PVector(width, 0));
  bottom = new LineSegment(new PVector(0, height), new PVector(width, height));
  left = new LineSegment(new PVector(0, 0), new PVector(0, height));
  right = new LineSegment(new PVector(width, 0), new PVector(width, height));
  lineSegments.add(top);
  lineSegments.add(bottom);
  lineSegments.add(left);
  lineSegments.add(right);
  r = new PVector();
  
  for(int i = 0; i < numRays; ++i)
  {
    float angle = (TWO_PI / numRays) * i;
    rays.add(new Ray(new PVector(width / 2, height / 2), new PVector(cos(angle), sin(angle))));
  }
  
  for(int i = 0; i < numSegments; ++i)
  {
    lineSegments.add(new LineSegment(new PVector(random(width), random(height)), new PVector(random(width), random(height))));
  }
}

void draw()
{
  background(0);
  
  for(Ray ray : rays)
  {
    ray.origin.x = mouseX;
    ray.origin.y = mouseY;
    
    float minDist = 9999999;
    
    for(LineSegment segment : lineSegments)
    {
      PVector intersection = ray.cast(segment);
      
      if(intersection != null) 
      { 
        if(ray.t < minDist) 
        {
          minDist = ray.t;
          r = PVector.sub(intersection, ray.origin);
        }
      }
      
      segment.render();
    }
    
    stroke(255, 100);
    line(ray.origin.x, ray.origin.y, ray.origin.x + r.x, ray.origin.y + r.y);
  }
}
