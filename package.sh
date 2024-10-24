#!/usr/bin/env sh
set -e

drawio_version="v24.0.2"
drawio_path=/Users/mq/IdeaProjects/drawio

# cd $drawio_path
# git checkout "tags/${drawio_version}" -b ${drawio_version}
# cd -

rm -rf ./src

mkdir -p src/js/ge
mkdir -p src/js/shapes

cp -rf $drawio_path/src/main/webapp/mxgraph/css ./src
cp -rf $drawio_path/src/main/webapp/mxgraph/images ./src

cp -rf $drawio_path/src/main/webapp/mxgraph/src/* ./src/js
cp -rf $drawio_path/src/main/webapp/mxgraph/mxClient.js ./src

cp -rf $drawio_path/src/main/webapp/js/grapheditor/Actions.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/js/grapheditor/Editor.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/js/grapheditor/EditorUi.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/js/grapheditor/Menus.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/js/grapheditor/Shapes.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/js/grapheditor/Sidebar.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/js/grapheditor/Graph.js ./src/js/ge/
cp -rf $drawio_path/src/main/webapp/shapes/bpmn/mxBpmnShape2.js ./src/js/shapes/


# sed -i '' "s/@MXGRAPH-VERSION@/drawio@${drawio_version}/g" ./src/js/mxClient.js
# sed -i '' "s|'mxgraph/css/common.css'|mxBasePath + \"/css/common.css\"|g" ./src/js/mxClient.js
# sed -i '' "s/|| !(typeof module === 'object' && module.exports != null)//g" ./src/js/mxClient.js

# sed -i '' "s/^Editor = function/const Editor = function/g" ./src/js/ge/Editor.js
# sed -i '' "s/^OpenFile = function/const OpenFile = function/g" ./src/js/ge/Editor.js
# sed -i '' "s/^Graph = function/const Graph = function/g" ./src/js/ge/Graph.js
# sed -i '' "s/^HoverIcons = function/const HoverIcons = function/g" ./src/js/ge/Graph.js
# sed -i '' "s/mxCellEditorGetInitialValue = mxCellEditor/const mxCellEditorGetInitialValue = mxCellEditor/g" ./src/js/ge/Graph.js
# sed -i '' "s/mxCellEditorGetCurrentValue = mxCellEditor/const mxCellEditorGetCurrentValue = mxCellEditor/g" ./src/js/ge/Graph.js
# sed -i '' "s/mxGraphHandlerIsValidDropTarget = mxGraphHandler./const mxGraphHandlerIsValidDropTarget = mxGraphHandler./g" ./src/js/ge/Graph.js
# sed -i '' "s/window.DOM_PURIFY_CONFIG/DOM_PURIFY_CONFIG/g" ./src/js/ge/Graph.js
# sed -i '' "s/pairs = cell.style/let pairs = cell.style/g" ./src/js/ge/Graph.js

# sed -i '' "s/new window/new __mxOutput/g" ./src/js/ge/Graph.js
# sed -i '' "s/window.Sidebar/__mxOutput.Sidebar/g" ./src/js/ge/Graph.js

# sed -i '' "s/^EditorUi = function/const EditorUi = function/g" ./src/js/ge/EditorUi.js

# sed -i '' '/var dist = Math.sqrt/a\
#   var raster;
# ' src/js/handler/mxVertexHandler.js

# sed -i '' "s/window\[name\]/__mxOutput\[name\]/g" ./src/js/io/mxCodec.js


# ## 注释掉EditorUi无用代码
# #################### EditorUi.js START #################### 
# sed -i '' "s/this.createUi()/\/\/this.createUi()/g" ./src/js/ge/EditorUi.js
# sed -i '' "s/^EditorUi.prototype.createDivs/EditorUi.prototype.createDivs1/g" ./src/js/ge/EditorUi.js
# sed -i '' '/EditorUi.prototype.createDivs1/i\
# EditorUi.prototype.createDivs = function() {this.diagramContainer =this.container|| this.createDiv('geDiagramContainer');}
# ' ./src/js/ge/EditorUi.js

# ## 注释menu相关代码
# sed -i '' '/this.menus.get('\''navigation'\'')/{ 
#     i\
# /* 
# }' ./src/js/ge/EditorUi.js

# sed -i '' '/this.menus.get('\''align'\'')/{
#     N
#     N
#     a\
#     */
# }' ./src/js/ge/EditorUi.js


# ## 注释sidebar相关代码
# sed -i '' '/var effHsplitPosition/{ 
#     i\
# /* 
# }' ./src/js/ge/EditorUi.js

# sed -i '' '/if (sizeDidChange)/{ 
#     i\
# */ 
# }' ./src/js/ge/EditorUi.js

# sed -i '' '/this.menus = this.createMenus()/a\
# 	this.sidebar = new Sidebar(this);
# ' ./src/js/ge/EditorUi.js

# #################### EditorUi.js END #################### 

# sed -i '' 's/^Menus = function/const Menus = function/' ./src/js/ge/Menus.js

# sed -i '' 's/img == this.refreshTarget/img == me.refreshTarget/' ./src/js/ge/Sidebar.js
# sed -i '' '/var ui = this.editorUi;/i\
#   var me = this;
# ' ./src/js/ge/Sidebar.js


# sed -i '' '/this\.container\.style\.overflow/{ 
#     i\
# /* 
# }' ./src/js/ge/Sidebar.js

# sed -i '' '/this.init()/{ 
#     a\
# */ 
# }' ./src/js/ge/Sidebar.js


# sed -i '' "s/s = this.scale/var s = this\.scale/g" ./src/js/ge/Shapes.js

# npm run build

# cp -rf ./dist/mgraph.js /Users/mq/IdeaProjects/bpmn-universal/bpmn-web/web/src/utils/mxgraph/mxgraph.js







