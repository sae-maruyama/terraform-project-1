## 📁 プロジェクト構成

```
MY-TF-PROJECT/
├── .terraform/
├── modules/
│   ├── alb/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── autoscaling/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── database/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2-api/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── ec2-web/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── security/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
├── .gitignore
├── .terraform.lock.hcl
├── locals.tf
├── main.tf
├── outputs.tf
├── provider.tf
├── terraform.tfstate
├── terraform.tfstate.backup
└── variables.tf
```

## バックエンド設定
- **ローカルバックエンド**を使用

## 注意事項
- `terraform.tfvars`ファイルは機密情報を含む可能性があるため、`.gitignore`で除外
