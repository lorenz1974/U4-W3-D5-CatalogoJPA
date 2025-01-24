package u4w3.dao;

import u4w3.exception.*;

import u4w3.entities.ElementoCatalogo;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.NoResultException;
import java.util.List;

public class ElementoCatalogoDAO {

    private final EntityManager em;

    public ElementoCatalogoDAO(EntityManager em) {
        this.em = em;
    }

    public void save(ElementoCatalogo elemento) throws ErroreGenericoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            em.persist(elemento);
            transaction.commit();
        } catch (Exception exception) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante il salvataggio dell'elemento: " + exception.getMessage());
        }
    }

    public ElementoCatalogo findById(Long id) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            ElementoCatalogo elemento = em.find(ElementoCatalogo.class, id);
            if (elemento == null) {
                throw new ElementoNonTrovatoException("Nessun elemento trovato con ID: " + id);
            }
            return elemento;
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per ID: " + exception.getMessage());
        }
    }

    public boolean checkByISBN(String isbn) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            ElementoCatalogo check = em
                    .createQuery("SELECT e FROM ElementoCatalogo e WHERE e.codiceISBN = :isbn", ElementoCatalogo.class)
                    .setParameter("isbn", isbn)
                    .getSingleResult();
            // Se trova qualcosa, ritorna true
            return true;
        } catch (NoResultException exception) {
            // Se non trova nulla, ritorna false
            return false;
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per ISBN: " + exception.getMessage());
        }
    }

    public ElementoCatalogo findByISBN(String isbn) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            return em.createQuery("SELECT e FROM ElementoCatalogo e WHERE e.codiceISBN = :isbn", ElementoCatalogo.class)
                    .setParameter("isbn", isbn)
                    .getSingleResult();
        } catch (NoResultException exception) {
            throw new ElementoNonTrovatoException("Nessun elemento trovato con ISBN: " + isbn);
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per ISBN: " + exception.getMessage());
        }
    }

    public List<ElementoCatalogo> findByAnno(int anno) throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            return em
                    .createQuery(
                            "SELECT e FROM ElementoCatalogo e WHERE e.annoPubblicazione = :anno ORDER BY e.annoPubblicazione",
                            ElementoCatalogo.class)
                    .setParameter("anno", anno)
                    .getResultList();
        } catch (NoResultException exception) {
            throw new ElementoNonTrovatoException("Nessun elemento trovato per l'anno: " + anno);
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per l'anno: " + exception.getMessage());
        }
    }

    public List<ElementoCatalogo> findByAutore(String autore)
            throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            return em
                    .createQuery(
                            "SELECT e FROM ElementoCatalogo e WHERE LOWER(e.autore) LIKE :autore ORDER BY e.autore",
                            ElementoCatalogo.class)
                    .setParameter("autore", "%" + autore.toLowerCase() + "%")
                    .getResultList();
        } catch (NoResultException exception) {
            throw new ElementoNonTrovatoException("Nessun elemento trovato con autore: " + autore);
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per autore: " + exception.getMessage());
        }
    }

    public List<ElementoCatalogo> findByTitolo(String titolo)
            throws ErroreGenericoException, ElementoNonTrovatoException {
        try {
            return em
                    .createQuery(
                            "SELECT e FROM ElementoCatalogo e WHERE LOWER(e.titolo) LIKE :titolo ORDER BY e.titolo",
                            ElementoCatalogo.class)
                    .setParameter("titolo", "%" + titolo + "%")
                    .getResultList();
        } catch (NoResultException exception) {
            throw new ElementoNonTrovatoException("Nessun elemento trovato con titolo: " + titolo);
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante la ricerca dell'elemento per titolo: " + exception.getMessage());
        }
    }

    public void delete(ElementoCatalogo elemento) throws ErroreGenericoException, ElementoNonTrovatoException {
        EntityTransaction transaction = em.getTransaction();
        try {
            transaction.begin();
            if (elemento == null) {
                throw new ErroreGenericoException("Elemento non passato alla funzione di eliminazione");
            }
            if (em.find(ElementoCatalogo.class, elemento.getId()) == null) {
                throw new ElementoNonTrovatoException("Elemento non trovato nel database");
            }
            em.remove(elemento);
            transaction.commit();
        } catch (Exception exception) {
            if (transaction.isActive()) {
                transaction.rollback();
            }
            throw new ErroreGenericoException("Errore durante l'eliminazione dell'elemento: " + exception.getMessage());
        }
    }

    public List<ElementoCatalogo> findAll() throws ErroreGenericoException {
        try {
            return em.createQuery("SELECT e FROM ElementoCatalogo e", ElementoCatalogo.class).getResultList();
        } catch (Exception exception) {
            throw new ErroreGenericoException(
                    "Errore durante il recupero di tutti gli elementi: : " + exception.getMessage());
        }
    }
}