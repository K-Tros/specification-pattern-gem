module SpecPattern
    class Composite

        def initialize(spec)
            @spec = spec
        end

        def is_satisfied_by?(candidate)
            @spec.is_satisfied_by?(candidate)
        end

        def and(other)
            @spec = AndSpec.new(@spec, other)
        end

        def and_not(other)
            @spec = AndNotSpec.new(@spec, other)
        end

        def or(other)
            @spec = OrSpec.new(@spec, other)
        end

        def or_not(other)
            @spec = OrNotSpec.new(@spec, other)
        end

        def not(other)
            @spec = NotSpec.new(@spec, other)
        end
    end

    class AndSpec < Composite
        def initialize(left, right)
            @spec = self
            @left = left
            @right = right
        end

        def is_satisfied_by?(candidate)
            @left.is_satisfied_by?(candidate) && @right.is_satisfied_by?(candidate)
        end
    end

    class AndNotSpec < Composite
        def initialize(left, right)
            @spec = self
            @left = left
            @right = right
        end

        def is_satisfied_by?(candidate)
            @left.is_satisfied_by?(candidate) && !@right.is_satisfied_by?(candidate)
        end
    end

    class OrSpec < Composite
        def initialize(left, right)
            @spec = self
            @left = left
            @right = right
        end

        def is_satisfied_by?(candidate)
            @left.is_satisfied_by?(candidate) || @right.is_satisfied_by?(candidate)
        end
    end

    class OrNotSpec < Composite
        def initialize(left, right)
            @spec = self
            @left = left
            @right = right
        end

        def is_satisfied_by?(candidate)
            @left.is_satisfied_by?(candidate) || !@right.is_satisfied_by?(candidate)
        end
    end

    class NotSpec < Composite
        def initialize(spec)
            @spec = spec
        end

        def is_satisfied_by?(candidate)
            !@spec.is_satisfied_by?(candidate)
        end
    end
end

# Test code begins here

module Post
    class WithTitle
        def is_satisfied_by?(post)
            !post.title.empty?
        end
    end

    class WithTags
        def is_satisfied_by?(post)
            !post.tags.to_a.empty?
        end
    end

    class Published
        def is_satisfied_by?(post)
            !!post.published
        end
    end
end