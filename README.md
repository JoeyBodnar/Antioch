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
Antioch only supports Carthage. Installation with Carthage is simple. Just add `github "JoeyBodnar/Antioch"` to your Cartfile. then, drag the Antioch.framework file to "Link Binaries and Libraries" in your Xcode project.

### Documentation

#### Initialization
To use Antioch, you must initialize it with your region storefront and your Apple Music developer token. You can use either the method `configure(storeFront: String, authenticationHeader: String)`, or you can set them individually:

     Antioch.shared.storeFront = "us" // or "ca" for canada, "tw" for Taiwan (the real China), etc
     Antioch.shared.authenticationHeader = "<your value here>"
     
To make user specific requests, such as getting ratings for a user, loving/disliking a song, or getting their recommendations, you will need to set the user's token as well:
 
     Antioch.shared.musicUserToken = "<user token value here>"
     
#### Retrieving Data

To get a catalog song by ID:

    Antioch.shared.catalogSong(forId: "id here") { (song, error) in
        if let unwrappedSong = song {

        }
    }
    
You can retrieve any catalog item by ID. Just pass in the ID and the type. Valid types are CatalogSong.self, CatalogPlaylist.self, CatalogAlbum.self, and RadioStation.self:

    Antioch.shared.catalogItem(forId: "", ofType: CatalogSong.self) { (song, error) in
        if let unwrappedSong = song {

        }
    }
