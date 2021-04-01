import React, {Component} from "react";
import { BrowserRouter as Router, Link, Route, Switch } from 'react-router-dom';
import Tabs from '@material-ui/core/Tabs';
import Tab from '@material-ui/core/Tab';
import Paper from '@material-ui/core/Paper';
import Character from "./Character";
import Works from "./Works";

// タブ画面を表示する
export default class TabLists extends Component {
  constructor(props) {
    super(props);
    this.state = {
      value: 0
    };
    this.handleSelect = this.handleSelect.bind(this);
    this.handleClick = this.handleClick.bind(this);
  }

  handleSelect = (index, last) => {
    console.log('Selected tab: ' + index + ', Last tab: ' + last);
  }

  handleClick = () => {
    this.setState({
      value: 1
    });
  };
  
  render () {
    return (
      <Router>
        <div>
        <Paper>
          <Tabs
            value={this.state.value}
            onClick={this.handleClick}
            onSelect={this.handleSelect}
            indicatorColor="primary"
            textColor="primary"
            // centered
          >
          <Tab label="作品名"　/>
          <Tab label="キャラクター" />
          
          <Switch>
            <Route
              exact path="/works"
              render={()=><Works work={this.props.work} />}
            />
            <Route
              path="/characters"
              render={()=><Character character={this.props.character}  />}
            />
          </Switch> 
          </Tabs>
        </Paper>
        </div>
      </Router>
    );
  }  
}
