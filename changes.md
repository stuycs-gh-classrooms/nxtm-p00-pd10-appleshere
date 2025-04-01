[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/gbHItYk9)
## Project 00
### NeXTCS
### Period: 10
## Name0: Daviana Ramnauth
## Name1: Checed Ligh
---

This project will be completed in phases. The first phase will be to work on this document. Use github-flavoured markdown. (For more markdown help [click here](https://github.com/adam-p/markdown-here/wiki/Markdown-Cheatsheet) or [here](https://docs.github.com/en/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) )

All projects will require the following:
- Researching new forces to implement.
- Method for each new force, returning a `PVector`  -- similar to `getGravity` and `getSpring` (using whatever parameters are necessary).
- A distinct demonstration for each individual force (including gravity and the spring force).
- A visual menu at the top providing information about which simulation is currently active and indicating whether movement is on or off.
- The ability to toggle movement on/off
- The ability to toggle bouncing on/off
- The user should be able to switch _between_ simluations using the number keys as follows:
  - `1`: Gravity
  - `2`: Spring Force
  - `3`: Drag
  - `4`: Custom Force
  - `5`: Combination


## Phase 0: Force Selection, Analysis & Plan
---------- 

#### Custom Force: Buoyant Force 

### Forumla
What is the formula for your force? Including descriptions/definitions for the symbols. (You may include a picture of the formula if it is not easily typed.)

F = ρ V g
Force = density of fluid * volume of submerged object OR volume of fluid displaced * acceleration due to gravity
Because the simulation will be 2 dimensional, volume in this equation will be area

### Custom Force
- What information that is already present in the `Orb` or `OrbNode` classes does this force use?
  - Acceleration due to gravity is something that is set in the driver file

- Does this force require any new constants, if so what are they and what values will you try initially?
  - Density of the fluid in mass per area, initial value will be pretty low: 0.1 mass units per pixel

- Does this force require any new information to be added to the `Orb` class? If so, what is it and what data type will you use?
  - Area (derived from radius): will use a float
  - A method that will return a PVector to be used as an argument in the applyForce() method

- Does this force interact with other `Orbs`, or is it applied based on the environment?
  - Applied based on the environment
  - Later versions may involve a buoyant force not in a singular direction throught the whole screen, for instance, buoyant force around a fixed orb that acts as a planet.

- In order to calculate this force, do you need to perform extra intermediary calculations? If so, what?
  - No

--- 

### Simulation 1: Gravity
Describe how you will attempt to simulate orbital motion.

We will apply the appropriate calculated PVector for orbs free to move, and assign a non-moving orb as a stationary mass. The PVector applied should follow the formula F = (G * m1 * m2) / r^2. OR, if that doesn't work, we can set a stationary mass, calculate the PVector that would represent the gravatiational field at a given point within the field, and then apply that acceleration to the moving masses. Though, we would most likely have to simulate the motion using F = m(v^2 / r).


--- 

### Simulation 2: Spring
Describe what your spring simulation will look like. Explain how it will be setup, and how it should behave while running.

We will create a linked list of orbs that will display differently colored springs depending on whether the spring has been compressed or stretched. All springs will have the same spring constant; if the spring is compressed, the orbs should be repelled from one another- if the spring is stretched, the orbs should be pulled towards one another. 

--- 

### Simulation 3: Drag
Describe what your drag simulation will look like. Explain how it will be setup, and how it should behave while running.

Drag will simply add a force (calculated PVector) to an orb in the direction opposite to its velocity, ultimately "slowing the orb down". It would only be enacted within a set range of y-coordinates (if the moving orbs pass height/2, for example) to visually demonstrate the difference between orbs expereiencing no drag and orbs experiencing drag. 

--- 

### Simulation 4: Custom force
Describe what your Custom force simulation will look like. Explain how it will be setup, and how it should behave while running.

We will simulate three instances or the orb class, one with a density greater than the fluid(it will sink), one less than(it will float), one that is the same (it will not accelerate)

--- 

### Simulation 5: Combination
Describe what your combination simulation will look like. Explain how it will be setup, and how it should behave while running.

The fluid class will have a value of drag to more realistically show the effects of fluid.

