module PostCategoriesHelper
    # Generates hierarchical category options for dropdowns
    def category_options(exclude_category = nil)
      category_list = []
      build_category_list(PostCategory.where(parent_category_id: nil), category_list, exclude_category)
      category_list
    end
  
    private
  
    # Recursive method to build category list
    def build_category_list(categories, category_list, exclude_category, prefix = '')
      categories.each do |category|
        next if category == exclude_category
        category_list << [prefix + category.name, category.id]
        build_category_list(category.child_categories, category_list, exclude_category, prefix + '-- ')
      end
    end
  end
  