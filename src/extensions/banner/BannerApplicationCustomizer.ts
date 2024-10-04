import * as React from 'react';
import * as ReactDom from 'react-dom';
import { override } from '@microsoft/decorators';
import { Log } from '@microsoft/sp-core-library';
import {
  BaseApplicationCustomizer,
  PlaceholderContent,
  PlaceholderName
} from '@microsoft/sp-application-base';

import * as strings from 'BannerApplicationCustomizerStrings';
import { IBannerProps } from './Components/IBannerProps';
import { Banner } from './Components/Banner';

const LOG_SOURCE: string = 'BannerApplicationCustomizer';

/**
 * If your command set uses the ClientSideComponentProperties JSON input,
 * it will be deserialized into the BaseExtension.properties object.
 * You can define an interface to describe it.
 */
export interface IBannerApplicationCustomizerProperties {
  bannerText: string;
}

/** A Custom Action which can be run during execution of a Client Side Application */
export default class BannerApplicationCustomizer
  extends BaseApplicationCustomizer<IBannerApplicationCustomizerProperties> {

  private _headerPlaceholder: PlaceholderContent | undefined;

  @override
  public onInit(): Promise<void> {
    Log.info(LOG_SOURCE, `Initialized ${strings.Title}`);

    let message: string = this.properties.bannerText;
    if (!message) {
      message = 'Leider wurde kein Banner-Text angegeben.';
    }

    this.context.placeholderProvider.changedEvent.add(this, this.renderHeader);

    return Promise.resolve();
  }

  private renderHeader(): void {
    if (!this._headerPlaceholder) {
      this._headerPlaceholder = this.context.placeholderProvider.tryCreateContent(
        PlaceholderName.Top,
        { onDispose: () => { } }
      );

      if (!this._headerPlaceholder) {
        Log.error(LOG_SOURCE, new Error('Could not find placeholder Top'));
        return;
      }

      const banner: React.ReactElement<IBannerProps> = React.createElement(Banner,
        {
          message: this.properties.bannerText
        }
      );

      ReactDom.render(banner, this._headerPlaceholder.domElement);
    }
  }
}
