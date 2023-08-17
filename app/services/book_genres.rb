class BookGenres
    def self.genre_options
      fiction_genres = [
        { value: 'fiction', label: 'Fiction' },
        { value: 'Action Adventure', label: 'Action Adventure' },
        { value: "Children's Fiction", label: "Children's Fiction" },
        { value: 'Contemporary Fiction', label: 'Contemporary Fiction' },
        { value: 'Crime', label: 'Crime' },
        { value: 'Fantasy', label: 'Fantasy' },
        { value: 'Historical Fiction', label: 'Historical Fiction' },
        { value: 'Horror', label: 'Horror' },
        { value: 'Humor', label: 'Humor' },
        { value: 'Literary Fiction', label: 'Literary Fiction' },
        { value: 'Magic Realism', label: 'Magic Realism' },
        { value: 'New Adult', label: 'New Adult' },
        { value: 'Romance', label: 'Romance' },
        { value: 'Science Fiction', label: 'Science Fiction' },
        { value: 'Speculative Fiction', label: 'Speculative Fiction' },
        { value: 'Thriller', label: 'Thriller' },
        { value: 'Western', label: 'Western' },
        { value: "Women's Fiction", label: "Women's Fiction" },
        { value: 'Young Adult', label: 'Young Adult' }
      ]
  
      non_fiction_genres = [
        { value: 'nonfiction', label: 'Non-Fiction' },
        { value: 'Biography', label: 'Biography' },
        { value: 'Business', label: 'Business' },
        { value: 'Diaries', label: 'Diaries' },
        { value: 'History', label: 'History' },
        { value: 'Law', label: 'Law' },
        { value: 'Philosophy', label: 'Philosophy' },
        { value: 'Religious', label: 'Religious' },
        { value: 'Scientific writing', label: 'Scientific writing' },
        { value: 'True crime', label: 'True crime' }
      ]
  
      [
        *fiction_genres.map { |genre| [genre[:label], genre[:value]] },
        ['---', nil, { class: 'dropdown-divider' }],
        *non_fiction_genres.map { |genre| [genre[:label], genre[:value]] }
      ]
    end
  end
  