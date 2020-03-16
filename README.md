# Procedural World Generation
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fronaldvandenbroek%2Fprocedural-world-generation.svg?type=shield)](https://app.fossa.io/projects/git%2Bgithub.com%2Fronaldvandenbroek%2Fprocedural-world-generation?ref=badge_shield)

[Github Page](https://ronaldvandenbroek.github.io/procedural-world-generation/)

Procedural World Generation using Processing and Java

Personal project capable of generating continents with a height, temperature, rainfall and biome map. 

Initially pure Processing was used (till version 4), however with version 5 the switch was made to a Java project using Processing as a library, this was done to increase flexibility by not being limited to the Processing IDE. 

## Setup
### Libraries
Version 5 needs 2 external libraries that have to be imported manually:
- **core.jar** The Processing library
- **controlP5.jar** The GUI library used together with Processing

These libraries can be obtained by downloading the latest Processing and installing the controlP5 plugin via the Processing IDE at the following paths respectively (assuming default install locations):
- \Program Files\processing-3.5.3\core\library\core.jar
- \User\\%userprofile%\Documents\Processing\libraries\controlP5\library\controlP5.jar

## Example Output

| v3 WorldGen Examples  | Click on image for full size |
| :---: | :---: |
| <img src="docs/images/v3_biome_map.png" style="width: 50%;" /><br />Biome Map | <img src="docs/images/v3_textured_end_result.png" style="width: 50%;" /><br />Textured End Result |
| <img src="docs/images/v3_height_map.png"  style="width: 50%" /><br />Height Map | <img src="docs/images/v3_temperature_map.png"  style="width: 50%" /><br />Temperature Map |
| <img src="docs/images/v3_rain_map1.png"  style="width: 50%" /><br />Rain Map 1 | <img src="docs/images/v3_rain_map2.png"  style="width: 50%" /><br />Rain Map 2 |
| <img src="docs/images/v3_rain_map3.png"  style="width: 50%" /><br />Rain Map 3 | <img src="docs/images/v3_combined_rain_map.png"  style="width: 50%" /><br />Combined Rain Map |


## License
[![FOSSA Status](https://app.fossa.io/api/projects/git%2Bgithub.com%2Fronaldvandenbroek%2Fprocedural-world-generation.svg?type=large)](https://app.fossa.io/projects/git%2Bgithub.com%2Fronaldvandenbroek%2Fprocedural-world-generation?ref=badge_large)