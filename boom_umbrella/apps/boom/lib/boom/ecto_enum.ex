import EctoEnum

defenum(NovellaType, :novella_type_novella, [:text, :visual])
defenum(NovellaTypeStatus, :novella_type_status, [:private, :public])

defenum(SlideType, :slide_type_delete, [:delete, :not_delete])

defenum(TreeTypeDelete, :tree_type_delete, [:delete, :not_delete])

defenum(TreeType, :tree_type, [:global, :tree])

defenum(LikeType, :like_type, [:like, :dis_like, :not_like])
defenum(TableType, :table_type, [:post, :novella, :user, :comments, :tree, :global])

defenum(ImageType, :table_type, [:novella_avatar, :novella_img, :global])
defenum(PostType, :post_type, [:user, :global])

# Public Novella
defenum(PublicType, :public_type, [:public])
