# this is a global that controls weather lazys should be enabled,
# if it is false each call will recalculate the value
LAZYMODE = true

# this is private method that is used to allow lazy attributes
# small things that take
lazy = (obj,name,f) ->
  if LAZYMODE
    if not obj["_lazy_"+name]?
      obj["_lazy_"+name] = f()
    obj["_lazy_"+name]
  else
    f()