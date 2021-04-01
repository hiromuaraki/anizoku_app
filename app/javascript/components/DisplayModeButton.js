import React, {Component} from "react";
import PropTypes from "prop-types";
import Switch from '@material-ui/core/Switch';
import FormControlLabel from '@material-ui/core/FormControlLabel';
import SearchForm from './SearchForm';

export default class DisplayModeButton extends Component {
  constructor(props) {
    super(props);
    // mode off
    this.state = {
      displayMode: false
    };

    this.handleDisplayModeChange = this.handleDisplayModeChange.bind(this);
  }

  // ディスプレイモードをON OFFの切り替え
  handleDisplayModeChange = (e) => {
    this.setState({
      displayMode: e.target.checked
    });
  }

  render () {
    const isChecked = this.state.displayMode;
    let mode;
    if (isChecked) {
      mode = (
        <div>
            <FormControlLabel
              control = {
                <Switch
                checked={this.state.displayMode}
                onChange={this.handleDisplayModeChange}
                color="primary"
                />
              }
              label="オタク"
              />
            <SearchForm />
          </div>
      );
    } else {
      mode = (
        <FormControlLabel
          control={
            <Switch
              checked={this.state.displayMode}
              onChange={this.handleDisplayModeChange}
              color="primary"
            />
          }
          label="ノーマル"
        />
      );
    }
    return(
      <div>
        {mode}
      </div>

    );
  }
}

DisplayModeButton.prototypes = {
  display_mode: PropTypes.bool
};