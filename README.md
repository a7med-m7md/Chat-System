# Chat System challenge
It's a simple REST API application it has some applications and each application has a number of chats and every chat has a number of messages.

## Installation
`docker-compose up`


## Routes

| Route                  | Method           | Notes  |
| ---------------------- |:-------| -----:|
| /application           | GET   | Get all applications  |
| /applications          | POST  | Create new application|
| /applications/:token   | GET   | Get a single application |
| /applications/:token   | PATCH | Edit the application name |
| /applications/:token/chats  | GET | Get all chats of a specific token|
| /applications/:token/chats  | POST | Create new chat to the given token |
| /applications/:token/chats/:number | GET | Get a single chat |
| /applications/:token/chats/:number/messages | GET | Get all messages belongs to this chat number|
| /applications/:token/chats/:number/messages | POST | Create a message to the specified chat |
| /applications/:token/chats/:number/messages/search?keyword=value | GET |  Get all the partially matched values inside a specific chat |



**Creating application**
### request 
`curl http://localhost:3001/applications/
   -H "Accept: application/json" `

### response
    [{
        "token": "61c73fb3cec546e016b43ff6c05bafb5bf90cdce",
        "chats_count": 1,
        "name": "Ahmed El-Sherbini",
        "created_at": "2022-07-06T00:27:11.000Z",
        "updated_at": "2022-07-08T03:32:37.000Z"
    },
    {
        "token": "509536a7ebbe8d927c4a34f06eec6acb50929a6a",
        "chats_count": 0,
        "name": "madgy",
        "created_at": "2022-07-06T00:27:16.000Z",
        "updated_at": "2022-07-06T00:27:16.000Z"
    },
    {
        "token": "1b3b8c2601369e32575d2aae3f23d7c30361fa79",
        "chats_count": 8,
        "name": "aya",
        "created_at": "2022-07-06T00:27:20.000Z",
        "updated_at": "2022-07-06T06:41:06.000Z"
    }]

**Retrieving all applications**
### request 
` curl -X POST http://localhost:3001/applications/
   -H "Content-Type: application/json"
   -d '{"name": "Mahmoud"}'   `

### response
    [{
        "token": "8a89ec464db041a4d0c2ec230f187016849f1da6",
        "chats_count": 0,
        "name": "Mahmoud",
        "created_at": "2022-07-08T04:59:12.000Z",
        "updated_at": "2022-07-08T04:59:12.000Z"
    }]

**Get specific application**
#### request
`curl http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce
   -H "Accept: application/json" `

### response 
        [{
            "token": "61c73fb3cec546e016b43ff6c05bafb5bf90cdce",
            "chats_count": 1,
            "name": "Ahmed El-Sherbini",
            "created_at": "2022-07-06T00:27:11.000Z",
            "updated_at": "2022-07-08T03:32:37.000Z"
        }]

**Update name of specific application**
### request
`curl -X PATCH http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce
     -H 'Content-Type: application/json'
     -H 'Accept: application/json'
     -d '{"name": "Ahmed Mohamed"}'`

### response
    [{
        "name": "Ahmed Mohamed",
        "token": "61c73fb3cec546e016b43ff6c05bafb5bf90cdce",
        "chats_count": 1,
        "created_at": "2022-07-06T00:27:11.000Z",
        "updated_at": "2022-07-08T05:05:58.000Z"
    }]


**Retreiving all chats of specified token**
### request
`curl http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce/chats
   -H "Accept: application/json" `

#### response
    [{
        "messages_count": 3,
        "number": 30,
        "created_at": "2022-07-06T03:49:25.000Z",
        "updated_at": "2022-07-06T06:32:13.000Z"
    },
    {
        "messages_count": 0,
        "number": 80,
        "created_at": "2022-07-08T03:40:06.000Z",
        "updated_at": "2022-07-08T03:40:06.000Z"
    }]

**Create new chat belongs to a specific token**
### request 
` curl -X POST http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce/chats/
   -H "Content-Type: application/json"
   -d '{"number": 56}'   `

### response
    [{
        "number of chats": 5
    }]

**Getting info about specific chat with its number and token**
### request
`curl http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce/chats/30
   -H "Accept: application/json" `

### response

    [{
        "messages_count": 3,
        "number": 30,
        "created_at": "2022-07-06T03:49:25.000Z",
        "updated_at": "2022-07-06T06:32:13.000Z"
    }]


request 

` curl http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce/chats/30/messages
   -H "Content-Type: application/json"  `

response 

    [{
        "content": "First messsage",
        "number": 1,
        "created_at": "2022-07-06T03:54:55.000Z",
        "updated_at": "2022-07-06T03:54:55.000Z"
    },
    {
        "content": "Hello guys",
        "number": 2,
        "created_at": "2022-07-06T03:57:58.000Z",
        "updated_at": "2022-07-06T03:57:58.000Z"
    },
    {
        "content": "sunny day",
        "number": 3,
        "created_at": "2022-07-06T04:45:10.000Z",
        "updated_at": "2022-07-06T04:45:10.000Z"
    }]

request

` curl -X POST http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce/chats/30/messages
   -H "Content-Type: application/json"
   -d '{"content": "I'm happy to share that with you"}'   `

response

    [{
        "number of messages": 4
    }]


request 

` curl http://localhost:3001/applications/61c73fb3cec546e016b43ff6c05bafb5bf90cdce/chats/30/messages/search?keyword=f
   -H "Content-Type: application/json"  `

response

    [{
        "content": "First messsage",
        "number": 1,
        "created_at": "2022-07-06T03:54:55.000Z",
        "updated_at": "2022-07-06T03:54:55.000Z"
    }]

