import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Window {

    visible: true
    width: 480
    height: 640
    color: "#333333"
    title: qsTr("Todo")

    // prevent window resize below these values
    minimumWidth: 200
    minimumHeight: 200

    // model to manage our data
    ListModel { id: todoModel }

    // show children in a column (one below another)
    // this will show input field and button above
    // and scrolling list below
    ColumnLayout {
        anchors.fill: parent
        anchors.margins: 15

        // show children in a row (one next to each other)
        RowLayout {
            Layout.fillWidth: true
            spacing: 15

            // show this above our todoList so when scrolling
            // it's not covering our input field
            z: 1

            TextField {
                id: todoInputField
                placeholderText: qsTr("New")
                Layout.fillWidth: true
            }

            RoundButton {
                text: "\u2795" // unicode heavy plus sign
                onClicked: {
                    // add data to our model
                    todoModel.append({ content: todoInputField.text })
                    todoInputField.text = ''
                }
            }
        }

        ListView {
            id: todoList

            // use the model we defined above to render list
            model: todoModel

            Layout.fillWidth: true
            Layout.fillHeight: true

            delegate: ColumnLayout {
                width: todoList.width
                height: 55

                RowLayout {
                    Layout.fillWidth: true
                    spacing: 15

                    // allow editing, so we could also store it on change in the future
                    TextField {
                        color: "#fff"
                        background: Item {}
                        // render data - you can write just 'content' instead of 'model.content'
                        text: model.content
                        Layout.fillWidth: true
                    }

                    RoundButton {
                        text: "\u2796" // unicode heavy minus sign
                        // remove this element from model by index
                        // each delegate inside has access to "self" index property so we
                        // can know which element this is
                        onClicked: todoModel.remove(model.index)
                        height: parent.height
                    }
                }
                Rectangle { color: "#666"; height: 1; Layout.fillWidth: true }
            }
        }
    }
}
