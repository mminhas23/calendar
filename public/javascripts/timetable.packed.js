function $_(elemId) {
    return document.getElementById(elemId)
}
function Control(className, innerHTML, mouseOver, mouseOut) {
    var ctl = document.createElement("a");
    ctl.className = className;
    ctl.innerHTML = innerHTML;
    ctl.onmouseover = function() {
        mouseOver()
    };
    ctl.onmouseout = function() {
        mouseOut()
    };
    return ctl
}
function Scroll(div, direction) {
    if (direction == "left") {
        this.startLeftScroll(div)
    }
    if (direction == "right") {
        this.startRightScroll(div)
    }
}
Scroll.prototype = {startLeftScroll:function(div) {
    var t = this;
    this.scrollInterval = window.setInterval(function() {
        t.scroll(div, 'left')
    }, 12)
},startRightScroll:function(div) {
    var t = this;
    this.scrollInterval = window.setInterval(function() {
        t.scroll(div, 'right')
    }, 12)
},stop:function() {
    window.clearInterval(this.scrollInterval)
},scroll:function(div, direction) {
    if ((direction == "left") || (direction = "right")) {
        $_(div).scrollLeft += direction == "left" ? -6 : 6
    }
}};
function Controls(divToControl) {
    var left = new Control("left", "&lt;", function() {
        this.sLeft = new Scroll(divToControl, 'left')
    }, function() {
        this.sLeft.stop()
    });
    var right = new Control("right", "&gt;", function() {
        this.sRight = new Scroll(divToControl, 'right')
    }, function() {
        this.sRight.stop()
    });
    var ctlDiv = document.createElement("div");
    ctlDiv.className = "controls";
    ctlDiv.appendChild(left);
    ctlDiv.appendChild(right);
    return ctlDiv
}
function put0b4(number) {
    if (number < 10) {
        number = '0' + number
    }
    return number
}
function Holder(childClass) {
    this.parentId = childClass + "Holder";
    this.childClass = childClass
}
function Child() {
}
Child.prototype = {callBack:null,className:null,contents:null,left:null,length:1,getDiv:function() {
    var div = document.createElement("div");
    div.className = this.className;
    div.innerHTML = this.contents;
    if (this.className == "event") {
        div.style.margin = "0px 0px 0px " + this.left + "px";
        div.style.width = ((this.length * 120) + ((this.length - 1) * 8)) + "px";
        if (typeof this.callBack != "undefined") {
            var thisCallBack = this.callBack;
            div.onclick = function() {
                thisCallBack()
            }
        }
    }
    return div
}};
Holder.prototype = {parentId:null,childClass:null,lastLeft:0,addChild:function(child) {
    child.className = this.childClass;
    var thisChildLeft = parseFloat(child.left) + parseFloat(child.length);
    child.left = (child.left - this.lastLeft) * 128;
    this.lastLeft = thisChildLeft;
    var childDiv = child.getDiv();
    this.div.appendChild(childDiv)
},toDiv:function() {
    var holderDiv = document.createElement("div");
    holderDiv.className = this.parentId;
    this.div = holderDiv;
    return holderDiv
}};
function Timetable(parentDiv) {
    this.parentDiv = parentDiv;
    $_(parentDiv).className = "timetable";
    var hourHolder = new Holder("hour");
    $_(this.parentDiv).appendChild(hourHolder.toDiv());
    var eventHolder = new Holder("event");
    var eHdiv = eventHolder.toDiv();
    eHdiv.appendChild(new Controls(parentDiv));
    $_(this.parentDiv).appendChild(eHdiv);
    for (var x = 0; x < 24; x++) {
        var hour = new Child();
        hour.contents = put0b4(x) + ":00 &raquo; " + put0b4(x + 1) + ":00";
        hourHolder.addChild(hour)
    }
    this.hourHolder = hourHolder;
    this.eventHolder = eventHolder;
    this.goToNow()
}
function base60(base100) {
    base100 = base100 * 1;
    base100 = base100.toFixed(2);
    var mn = Math.floor(base100.substring(base100.length - 2, base100.length) / 0.6);
    return Math.floor(base100) + '.' + mn
}
Timetable.prototype = {addEvent:function(desc, start, length, callBack) {
    var evt = new Child();
    evt.contents = desc;
    evt.left = base60(start);
    evt.length = base60(length);
    evt.callBack = callBack;
    this.eventHolder.addChild(evt)
},goTo:function(hour) {
    $_(this.parentDiv).scrollLeft = base60(hour) * 128
},goToNow:function() {
    var theDate = new Date();
    var theHours = put0b4(theDate.getHours());
    var theMinutes = put0b4(theDate.getMinutes());
    var gotoString = theHours + '.' + theMinutes;
    this.goTo(gotoString)
}};