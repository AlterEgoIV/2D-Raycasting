class LineSegment
{
  PVector start, end, segment;
  
  LineSegment(PVector start, PVector end)
  {
    this.start = start;
    this.end = end;
    this.segment = PVector.sub(end, start);
  }
  
  void render()
  {
    stroke(255);
    line(start.x, start.y, end.x, end.y);
  }
}
