FinBox Lending IOS SDK
======================

Lending IOS SDK enables the user to complete the end to end lending journey.


## Add Lending SDK

Add the library to Pod file

```
pod 'FinBoxLending'
```


## Build FinBoxLending

Build FinBoxLending with API Key, Customer Id and other details

```
let _ = FinBoxLending.Builder()
    .environment(env: "UAT") // UAT or PROD
    .apiKey(key: apiKey)
    .customerID(id: customerID)
    .userToken(token: apiKey)
    .build();
```


## Show Lending Screen

Show the Lending Screen

```
LendingView() {
    payload in
    // Success or Failed journey based on the result code
    debugPrint("Result Code", payload.resultCode)
}
```
