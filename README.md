# database-spring2019
# Phase 1: software specification
- File: **softwareSpecifications.txt**
    - **_Kha_**: I, II, VI, VII
    - **_Soi_**: III, IV, V, VIII
# Phase 2: create a list of entity and relationship
- File: **entitiesList.txt**
	- **_Phong_**: read the specification and make a list of entities/relationship
	```
	Note: Please ask/exchange as soon as you get something confusing.
	```
## Note: use the following syntax:
```
I. Entities:
	1. Entity name
		- Entity attribute 1
		- Entity attribute 2 (derived)
		- Entity composite attribute
			+ Child attribute 1 (key)
			+ Child attribute 2
				-- Child of child 1
				-- Child of child 2 
				-- Child of child 3 (optional)
		- Entity attribute 3 (multivalue)
	...
II. Relationships:
	1. Relationship name
		- Relationship attribute 1
		- Relationship attribute 2 (derived)
		- Relationship composite attribute
			+ Child attribute 1 (key)
			+ Child attribute 2
				-- Child of child 1
				-- Child of child 2 
				-- Child of child 3 (optional)
		- Relationship attribute 3 (multivalue)
		- Entity 1:
			+ Mandatory (yes/no)
			+ cardinality: (1 or N...)
		- Entity 2:
			+ Mandatory (yes/no)
			+ cardinality: (1 or M...)
	...
```

## Progress
- Person entity OK
- Project entity OK
- Infrastructure management OK
- Community activity OK
# Phase 3: draw the ERD
- File at:
	> [Draw.IO ERD File](https://drive.google.com/file/d/1AwPx2zChkeIr8TM1oYwxKztD8FemDQsj/view)
**_Done!_**

# Phase 4: mapping
- File at:
	> [Draw.IO Mapping File](https://drive.google.com/file/d/1TKHB5bIFGBcwnpDZCCxpE8Vr54ypd_19/view)