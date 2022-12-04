
# テーブル設計

## users テーブル

| Column             | Type    | Options                   |
| ------------------ | ------- | ------------------------- |
| nickname           | string  | null: false               |
| email              | string  | null: false, unique: true |
| encrypted_password | string  | null: false               |
| last-name          | string  | null: false               |
| first-name         | string  | null: false               |
| last-name-kana     | string  | null: false               |
| first-name-kana    | string  | null: false               |
| user_birth_date_1i | date    | null: false               |
| user_birth_date_2i | date    | null: false               |
| user_birth_date_3i | date    | null: false               |

### Association

- has_many :items
- has_many :orders


## items テーブル

| Column                   | Type       | Options                         |
| ------------------------ | ---------- | ------------------------------- |
| item-name                | string     | null: false                     |
| item-info                | text       | null: false                     |
| item-category            | integer    | null: false                     |
| item-sales-status        | integer    | null: false                     |
| item-shipping-fee-status | integer    | null: false                     |
| item-prefecture          | integer    | null: false                     |
| item-scheduled-delivery  | integer    | null: false                     |
| item-price               | integer    | null: false                     |
| user                     | references | null: false, foreign_key: true  |

### Association

- has_one  :order
- belongs_to :user


## orders テーブル

| Column    | Type       | Options                         |
| --------- | ---------- | ------------------------------- |
| user      | references | null: false, foreign_key: true  |
| item      | references | null: false, foreign_key: true  |

### Association

- belongs_to :item
- has_one :address
- belongs_to :user


## addressees テーブル

| Column       | Type       | Options                        |
| ------------ | ---------- | ------------------------------ |
| postal-code  | integer    | null: false                    |
| city         | text       | null: false                    |
| prefecture   | integer    | null: false                    |
| addresses    | text       | null: false                    |
| building     | text       |                                |
| phone-number | integer    | null: false                    |
| order        | references | null: false, foreign_key: true |


### Association

- belongs_to :order


