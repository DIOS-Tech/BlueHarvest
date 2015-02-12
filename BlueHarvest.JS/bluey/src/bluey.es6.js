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

  var Login = React.createClass({
    userNameHandler: function(e) {
      this.setState({ userName: e.target.value });
    },
    passwordHandler: function(e) {
      this.setState({ password: e.target.value });
    },
    submitHandler: function(e) {
      // do something here so that the user is logged in
    },
    render: function() {
      return (
        <div className="login-container">
         <div className="login-container-title">Blue Harvest</div>
         <span>Username:</span>
         <br />
         <input type="text" onChange={this.userNameHandler}></input>
         <br />         
         <span>Password:</span>
         <br />
         <input type="password" onChange={this.passwordHandler}></input>
         <br />
         <br />
         <input type="submit" className="login-submit-button" onClick={this.submitHandler}></input>
        </div>
      );
    }
  });

  $(document).ready(() => {
    browser.openDevTools();

    /*<QuickLaunch items={quickLaunchItems} />,*/
    React.render(
      <Login />,
      document.getElementById("ui") 
    );
  });

  return my;
})(jQuery);

module.exports = Bluey;
