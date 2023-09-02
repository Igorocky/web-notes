open Expln_React_common
open Expln_React_render
open Expln_React_Mui
open Expln_React_Modal
open Expln_utils_promise

@react.component
let make = () => {
    let modalRef = useModalRef()
    let (msg, setMsg) = React.useState(() => "")

    let (item, setItem) = React.useState(() => None)

    let actSendReqToBe = () => {
        FE_BE_bridge.method1({msg:msg})->promiseMap(resp => {
            openInfoDialog(~modalRef, ~title="Response from the BE", ~text=resp.len->Belt_Int.toString, ())
        })->ignore
    }

    <Col>
        {"This is the root component."->React.string}
        <Row>
            <TextField
                size=#small
                style=ReactDOM.Style.make(~width="300px", ())
                label="Message"
                value=msg
                onChange=evt2str(str => setMsg(_ => str))
            />
            <Button onClick={_=>actSendReqToBe()}>
                {"Send"->React.string}
            </Button>
        </Row>
        <Expln_AutocompleteVirtualized value=item options={["A","B","C"]} size=#small onChange={v => setItem(_ => v)} label="Label" />
        <Expln_React_Modal modalRef />
    </Col>
    

}