# Antioch

Antioch is an Apple Music API wrapper. I use it in my Apple Music client, Sathorn.

#### Supported endpoints:

##### Catalog Endpoints
- getCatalogResource
- getMultipleCatalogResources
- charts

##### Library Endpointss
- getLibraryResource
- getMultipleLibraryResources
- getAllLibrayResources
- addItemsToLibrary
- recommendations
- songsForPlaylist
- addItemsToPlaylist

##### Ratings
- rate (an catalog or library item)
- rateWithId
- multipleRatings (get request)

##### Search
- searchCatalog
- searchLibrary
- searchHints

##### History
- recentStations

### Installation

#### Carthage
Antioch only supports Carthage. Installation with Carthage is simple. Just add `github "JoeyBodnar/Antioch"` to your Cartfile.
