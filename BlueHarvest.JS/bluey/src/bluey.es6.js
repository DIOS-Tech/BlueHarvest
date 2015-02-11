var Bluey = (function($) {
  "use strict";

  var my = {};

  var remote = require('remote'),
      browser = remote.getCurrentWindow();

  var quickLaunchItems = [
    {
      id: 0,
      text: "Administration",
      click: () => { alert("You clicked on Administration"); }
    },
    {
      id: 1,
      text: "Daily Schedule",
      click: () => { alert("You clicked on Daily Schedule"); } 
    },
    {
      id: 2,
      text: "Vacation Requests",
      click: () => { alert("You clicked on Vacation Requests"); }
    },
    {
      id: 3,
      text: "Employee Data",
      click: () => { alert("You clicked on Employee Data"); }
    },
    {
      id: 4,
      text: "Employee Tasks",
      click: () => { alert("You clicked on Employee Tasks"); }
    }
  ];

  var QuickLaunch = React.createClass({
    render: function() {
      var items = this.props.items.map((i) => { 
        return (
          <div key={i.id} onClick={i.click} className="quick-launch-item">{i.text}</div>
        );
      });

      return (
        <div className="quick-launch-container">
          {items}
        </div>
      );
    }
  });

  $(document).ready(() => {
    browser.openDevTools();

    React.render(
      <QuickLaunch items={quickLaunchItems} />,
      document.getElementById("ui") 
    );
  });

  return my;
})(jQuery);

module.exports = Bluey;
