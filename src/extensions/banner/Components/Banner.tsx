import * as React from 'react';
import styles from './Banner.module.scss';
import { IBannerProps } from './IBannerProps';

export class Banner extends React.Component<IBannerProps, {}> {
    public render(): JSX.Element {
        return (
            <div className={styles.Banner}>
                <div className={styles.bannerText}>
                    {this.props.message}
                </div>
            </div>
            );
    }
}

