# MasterDetailApp 

Master detail app to manage products.

## Getting Started

The app needs a connection with a REST API in order to show the products, however you can add products that you should see on the products list.

### Mock data

* [Mock.io](https://www.mocky.io) - here is a web page where you can mock your data
	
	```status code: 200 OK```
	```Content Type: application/json, UTF-8```

	```json response example```
	```[
    {
        "productId": 45,
        "productName": "Coke",
        "imageURL": "http://pngimg.com/uploads/cocacola/cocacola_PNG13.png",
        "price": 2.5,
        "expirationDate": "2019-07-13",
        "creationDate": "2016-07-17",
        "location": {
            "longitude": -75.559085,
            "latitude": 6.23779
        }
    },
    {
        "productId": 43,
        "productName": "Can beans",
        "imageURL": "https://cdn.pixabay.com/photo/2013/07/12/17/11/baked-beans-151747_1280.png",
        "price": 1.5,
        "expirationDate": null,
        "creationDate": "2017-02-10",
        "location": {
            "longitude": -75.559085,
            "latitude": 6.23779
        }
    },
    {
        "productId": 49,
        "productName": "Toothpaste",
        "imageURL": "http://pngimg.com/uploads/toothpaste/toothpaste_PNG18340.png",
        "price": 1.5,
        "expirationDate": null,
        "creationDate": "2015-07-11",
        "location": null
    }
	]```

	Once you click on ```Generate my HTTP Response``` it will generate a link that you need to add in the project.


### Prerequisites

Xcode Version 9.4.1 (9F2000)
Swift version 3.3

### Installing

Clone the project, and navigate to branch `develop` 

Before start you need to install the pods 
	type ```pod install``` on the command line
	and then open the project ```open MasterDetailApp.xcworkspace/```

Once xcode is opened, in the file `Helpers/Router.swift` change the baseURL which is on ServiceURL struct to the new link you just generated. 
Clean the project, build and Run the app. 


## Authors

* **Catalina Sánchez** - [cata1388](https://github.com/cata1388)

