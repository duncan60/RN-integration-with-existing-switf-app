'use strict';

import React from 'react';
import ReactNative, {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  NativeModules,
  NativeEventEmitter,
} from 'react-native';

const { AddRatingManager } = NativeModules;
const Rating = require('./Rating');

const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  content: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: 'green',
  },
  welcome: {
    fontSize: 20,
    color: 'white',
  },
  navBar: {
    backgroundColor: '#25507b',
    paddingTop: 32,
    paddingBottom: 10,
    paddingHorizontal: 10,
    flexDirection: 'row',
    justifyContent: 'space-between',
  },
  navBarText: {
    fontSize: 16,
  },
  navBarTitleText: {
    color: 'white',
    fontWeight: '500',
    alignSelf: 'center',
  },
  navBarLeftButton: {
    alignSelf: 'flex-start',
  },
  navBarRightButton: {
    alignSelf: 'flex-end',
  },
  navBarButtonText: {
    color: 'white',
  },
});

class AddRatingApp extends React.Component {
  constructor(props) {
    super(props);
    this._subscription = null;
    this.state = {
      identifier: props.identifier,
      currentRating: props.currentRating,
    };
  }
  componentDidMount() {
    const AddRatingManagerEvent = new NativeEventEmitter(AddRatingManager);
    this._subscription = AddRatingManagerEvent.addListener(
      'AddRatingManagerEvent',
      (info) => {
        console.log(JSON.stringify(info));
      }
    );
  }
  componentWillUnmount() {
    this._subscription.remove();
  }
  onRatingSelected(selectedRating) {
    this.setState({
      currentRating: selectedRating,
    });
  }
  _renderScene() {
    return (
      <Rating
        rating={this.state.currentRating}
        ratingSelectionHandler={this.onRatingSelected.bind(this)}
      />
    );
  }
  _renderNavLeftItem() {
    return (
      <TouchableOpacity
        onPress={() => {
          AddRatingManager.dismissPresentedViewController(this.props.rootTag);
        }}
        style={styles.navBarLeftButton}
      >
        <Text style={[styles.navBarText, styles.navBarButtonText]}>Cancel</Text>
      </TouchableOpacity>
    );
  }
  _renderNavRightItem() {
    if (this.state.currentRating > 0) {
      return (
        <TouchableOpacity
          onPress={() => {
            AddRatingManager.save(
              this.props.rootTag,
              this.state.currentRating,
              this.state.identifier
            );
          }}
          style={styles.navBarRightButton}
        >
          <Text style={[styles.navBarText, styles.navBarButtonText]}>Save</Text>
        </TouchableOpacity>
      );
    }
    return null;
  }

  render() {
    return (
      <View style={styles.container}>
        <View style={styles.navBar}>
          {this._renderNavLeftItem()}
          <Text style={[styles.navBarTitleText, styles.navBarText]}>
            Add Rating
          </Text>
          {this._renderNavRightItem()}
        </View>
        <Rating
          rating={this.state.currentRating}
          ratingSelectionHandler={this.onRatingSelected.bind(this)}
        />
      </View>
    );
  }
}

module.exports = AddRatingApp;
