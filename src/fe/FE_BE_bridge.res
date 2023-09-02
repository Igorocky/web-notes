open Expln_utils_promise

@val external fetch: (string,'a) => promise<{..}> = "fetch"

let createBeFunc = (path:string): ('req => promise<'resp>) => {
    Js.Json.
    req => {
        fetch(path, {
            "method": "POST",
            "headers": {
                "Content-Type": "application/json;charset=UTF-8"
            },
            "body": Js.Json.stringifyAny(req)
        }) 
            ->promiseFlatMap(res => res["text"](.))
            ->promiseMap(Js_json.deserializeUnsafe)
    }
}

let method1:BE_FE_types.method1Req=>promise<BE_FE_types.method1Resp> = createBeFunc(BE_FE_types.method1Path)