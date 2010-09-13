module Ralphy
  class BasicRect < Primitive
    tag :rect
    requires   :width, :height
  end
  class BasicCircle < Primitive
    tag :circle
    requires   :radius
  end
  class BasicEllipse < Primitive
    tag :ellipse
    requires :cx, :cy, :rx, :ry
  end
  class BasicLine < Primitive
    tag :line
    requires :x1, :y1, :x2, :y2
  end
  class BasicPolygon < Primitive
    tag :polygon
    requires :points
  end
  class BasicPolyline < Primitive
    tag :polyline
    requires :points
  end
  class BasicPath < Primitive
    tag :path
    requires :d
  end
  class BasicG < Primitive
    tag :g
  end
  class BasicDefs < Primitive
    tag :defs
  end
  class BasicFilter < Primitive
    tag :filter
    requires :id
  end
end
