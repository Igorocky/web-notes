open BE_FE_types

@module
external express:{..} = "express"

@module
external expressApp: () => {..} = "express"

let method1 = (req:method1Req):method1Resp => {
    {len:req.msg->Js_string.length}
}

external cast:'a => 'b = "%identity"

let registerPostHandler = (app:{..}, path:string, handler:'a=>'b):unit => {
    app["post"](. "/"++path, (req,res) => {
        res["send"](. handler(cast(req["body"])))
    })
}

let startExpressApp = (
    ~port:int,
):unit => {
    let app = expressApp()

    app["use"](. express["json"](. {"limit":"100MB"}))

    app->registerPostHandler(method1Path, method1)

    // app["post"](."/method1", (req,res) => {
    //     let body:method1Req = cast(req["body"])
    //     res["send"](.{len:body.msg->Js_string.length})
    // })

    app["listen"](. port, (.) => {
        Js.Console.log(`server is listening on ${port->Belt.Int.toString}`)
    })["on"](. "error", err => {
        Js.Console.log2(`error: `, err)
    })
    ()
}

let startApplication = () => {
    startExpressApp(~port=3001)
}