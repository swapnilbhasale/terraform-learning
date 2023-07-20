# Cross Reference Attribute References

## Typical Challenge
It can happen that in a single terraform file, you are defining two different resources. However ```resource 2``` might be dependent on some value of ```resource 1```

## Basics of Attributes
1. Each resource has its associated set of attributes.
2. Attributes are the fields in a resource that hold the values that end up in a state.

## Cross Reference Attribute References
1. Terrafrom alows us to reference that attribute of one resource to be used in a different resource.