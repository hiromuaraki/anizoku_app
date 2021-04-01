import React from "react";
import PropTypes from "prop-types";
import InputBase from '@material-ui/core/InputBase';
import SearchIcon from '@material-ui/icons/Search';
import IconButton from '@material-ui/core/IconButton';
import axios from 'axios';

export default class SearchForm extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      query: this.props.query,
      value: "",
      errorMessage: ""
    };

    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleChange = this.handleChange.bind(this);
  }

  handleChange = (e) => {
    this.setState({
      value: e.target.value
    });
  }

handleSubmit = (key) => {
    if (key === null || key === "") return;
    axios
      .get(`/api/v1/search?q=${key}`)
      .then((result) => {
        if (result.status === 200 && result.data != null) {
          return (
            <div>
              <TabLists
                works = {result.data.work}
                characters = {result.data.character}
              />
            </div>
            ); 
          }
        },
      )
      .catch((e) => {
        let errorMessage = e.response.message;
        this.setState({ 
          errorMessage: errorMessage });
        }
      );
    }
    
    render () {
      return (
          <form value={this.state.query} required={true}>
            <InputBase
              placeholder="作品名、キャラクター"
              inputProps={{ 'aria-label': 'search works' }}
              defaultValue={this.state.query}
              required={true}
              readOnly={false}
              onChange={this.handleChange}
              autoFocus={true}
              fullWidth={false}
            />

            <IconButton type="submit" aria-label="search" onClick={()=>this.handleSubmit(this.state.query)}>
              <SearchIcon />
            </IconButton>
            
          </form>
      );
    }
  }

SearchForm.prototypes = {
  value: PropTypes.string
};