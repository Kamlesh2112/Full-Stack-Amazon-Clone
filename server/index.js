//IMPORT FROM PACKAGES
const express = require('express'); //Similar to import 'package:express/express.dart';
const mongoose = require('mongoose');
const cors = require("cors");   
const adminRouter = require('./routes/admin');
//IMPORT FROM OTHER FILES
const authRouter = require('./routes/auth');
const productRouter = require('./routes/product');
const userRouter = require('./routes/user');


//INITIALIZATION
const PORT = 3000;
const app = express(); //creating an instance of express
const DB = "mongodb+srv://kamlesh:adtbeitw%2327017@cluster0.v7wgav7.mongodb.net/?retryWrites=true&w=majority";
//problem solved: # to %23
//MIDDLEWARE
// client -> middleware -> server -> client. For continuos listening use socket.io
app.use(cors());
app.use(express.json());
app.use(authRouter);
app.use(adminRouter);
app.use(productRouter);
app.use(userRouter);


//CONNECTIONS
mongoose.connect(DB).then(() => {console.log("Connection Successful")}).catch((err) => {console.log(err)});

//creating an API
//http://<youripaddress>/hello-world
/*app.get("/hello-world", (req, res) => {
    res.json({ hi: "Hello World" }); //send = text response json = json response
});*/

// GET, PUT, DELETE, UPDATE, POST CRUD OPERATIONS
app.listen(PORT, "0.0.0.0",() => { console.log(`connected at port ${PORT} `)});
